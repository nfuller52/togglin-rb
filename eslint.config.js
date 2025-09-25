import js from '@eslint/js'
import globals from 'globals'
import tseslint from 'typescript-eslint'
import react from 'eslint-plugin-react'
import reactHooks from 'eslint-plugin-react-hooks'
import jsxA11y from 'eslint-plugin-jsx-a11y'
import importPlugin from 'eslint-plugin-import'
import unusedImports from 'eslint-plugin-unused-imports'
import pluginQuery from '@tanstack/eslint-plugin-query'
import pluginRouter from '@tanstack/eslint-plugin-router'
import eslintConfigPrettier from 'eslint-config-prettier/flat'

export default [
  // Keep noise down; do NOT ignore app/frontend
  {
    ignores: ['**/node_modules/**', '**/dist/**', 'tmp/**', 'log/**', 'public/**', 'coverage/**'],
    linterOptions: { reportUnusedDisableDirectives: true },
  },

  // Base JavaScript recommendations
  js.configs.recommended,

  // TypeScript (fast, non-type-checked). These are arrays of configs, so spread them in.
  ...tseslint.configs.recommended,

  // React + JSX runtime (flat configs are plain objects; include them directly)
  react.configs.flat.recommended,
  react.configs.flat['jsx-runtime'],

  // A11y
  jsxA11y.flatConfigs.recommended,

  // Import rules (core + TS flavor)
  importPlugin.flatConfigs.recommended,
  importPlugin.flatConfigs.typescript,

  // TanStack plugins (these export arrays)
  ...pluginQuery.configs['flat/recommended'],
  ...pluginRouter.configs['flat/recommended'],

  // Project-specific scoping and house rules for your frontend
  {
    files: ['app/frontend/**/*.{ts,tsx}'],
    languageOptions: {
      ecmaVersion: 2024,
      sourceType: 'module',
      globals: { ...globals.browser, ...globals.es2024 },
    },
    settings: {
      react: { version: 'detect' },
      // TS resolver for eslint-plugin-import
      'import/resolver': {
        typescript: { project: true, alwaysTryTypes: true },
      },
    },
    plugins: { 'unused-imports': unusedImports },
    rules: {
      'react/react-in-jsx-scope': 'off',
      'react/prop-types': 'off',

      // Unused imports cleanup
      'unused-imports/no-unused-imports': 'error',
      'no-unused-vars': 'off',
      '@typescript-eslint/no-unused-vars': [
        'warn',
        { argsIgnorePattern: '^_', varsIgnorePattern: '^_' },
      ],

      // Import ordering (auto-fixable)
      'import/order': [
        'error',
        {
          groups: [
            'builtin',
            'external',
            'internal',
            'parent',
            'sibling',
            'index',
            'object',
            'type',
          ],
          pathGroups: [{ pattern: '@/**', group: 'internal', position: 'after' }],
          pathGroupsExcludedImportTypes: ['builtin'],
          alphabetize: { order: 'asc', caseInsensitive: true },
          'newlines-between': 'always',
        },
      ],
    },
  },

  // Turn off rules that conflict with Prettier (must be last)
  eslintConfigPrettier,
]
