# Togglin DB Schema

> Quick reference for each table and how data flows. Optimized for fast reads with DAG dependencies and published flag bundles.

## Tables

### organizations

**Purpose:** Supports multi-tenant operations

### environments

**Purpose:** Per-organization runtime contexts (e.g. dev, staging, production etc.)

### flags

**Purpose:** Top level flag definitions.

**Important Fields:**

- **key** a unique stable programmmatic identifier, editable by the user
- **kind** denotes whether the flag is a quick boolean (true/false) check or a multivariate check. See flag variants for details about a flag's multivariate checks.

### flag_variants

**Purpose:** Potential return values for a _multivariate_ flag.

**Important Fields:**

- **weight** optional traffic weight used by percentage rollout. sume of the weights defines the bucket ranges; with null meaning "not used in a weighted choice"

### flag_environment_states

**Purpose:** Per-environment flag runtime settings

**Important Fields:**

- **is_enabled** whether the flag is ON or OFF
- **default_variant_name** fallback variant name used when no rules match (for multivariate) or as the default choice. must match an existing `flag_variants.name` for/with the same `flag_id`
- **rule_plan** minimal evaluation plan (audience conditions, percentages, etc.) which is interpreted by the evaluator - the UI compiles these settings

### flag_dependencies

**Purpose:** Direct DAG edges between the flags. used for fast topological ordering during the publication of a bundle (see `flag_bundles`). Allows for O(1) cycle checks on write, before adding an edge P(arent) => C(hild), verify no closure row exists for the C => P.

**Important Fields:**

- **depth** path length (1 = direct parent, etc.)

### flag_bundles

**Purpose:** Immutable, read-only, fast read optimized snapshots per environment.

**Important Fields:**

- **bundle**: the structured data used by the client libraries to parse rules

## Data Flow

1. Create `flags` (and `flag_variants` if multivariate). Configure `flag_envitonment_states` (enable, default, rules). Manage edges in `flag_dependencies` (DAG). Service updates to `flag_dependency_closures`.

2. Publish operations will build a topological order and minimal per-flag entries while creating a new `flag_bundles` row (incrementing the `version` attribute).

3. Client's fetch the most recent bundle by org and environment.

## Q&A

Q: Do I need default_variant_name for boolean flags?
A: No, leave null. It’s mainly for multivariate fallbacks.

Q: Why are dependencies org‑global, not env‑scoped?
A: Keeps the model simpler and safer. If you later need different graphs per env, add environment_id to dependencies & closure.

Q: Where do percentage rollouts live?
A: In rule_plan (compiled audience/rollout tree) or in flag_variants.weight for simple splits. At publish time you can normalize both into the bundle.

Q: How do I pick a variant at runtime?
A: Deterministic hash of (user_id, flag_key) → 0..99,999, then walk cumulative weights to select the variant name.

Q: How do I evaluate dependencies?
A: Process bundle.topo left→right. For each flag, check requires/conflicts against already‑evaluated parents; only then evaluate rulePlan/weights.
