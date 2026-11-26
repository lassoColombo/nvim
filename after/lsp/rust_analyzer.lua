-- rust-analyzer settings.
--
-- Every key and default below was checked against the installed server with
-- `rust-analyzer --print-config-schema`. Only non-defaults are set, so each line
-- here is a deliberate change rather than a restatement of what you already get.
return {
  settings = {
    ['rust-analyzer'] = {
      -- Diagnostics come from clippy instead of plain `cargo check`. Both reuse
      -- the same incremental artifacts, so after the first build the cost is
      -- roughly equal, but clippy adds several hundred idiom lints on top of the
      -- compiler's errors.
      -- On a very large workspace (FOSS/nushell, 50 crates) add
      -- `workspace = false` here to lint only the crate being edited.
      check = {
        command = 'clippy',
      },

      -- rustc's own style lints: non_snake_case names, unused parens, redundant
      -- imports. Off by default in rust-analyzer.
      diagnostics = {
        styleLints = { enable = true },
      },

      -- Reference count in the hover popup, alongside the run/debug actions that
      -- are already on by default.
      hover = {
        actions = { references = { enable = true } },
      },

      -- Inlay hints stay off until <leader><leader><leader>h toggles them (see
      -- plugs/lsp/keys.lua), so this block can afford to be generous: it is a
      -- "show me what the compiler inferred" mode, not permanent screen noise.
      inlayHints = {
        -- Elided lifetimes written out: `fn f<'1>(s: &'1 str) -> &'1 str`.
        -- `skip_trivial` stays quiet on single-reference signatures, where the
        -- elision rule is obvious and the hint would only add clutter.
        lifetimeElisionHints = { enable = 'skip_trivial', useParameterNames = true },

        -- Match ergonomics made visible: the `ref` and `&` that a pattern binds
        -- for you without either appearing in the source.
        bindingModeHints = { enable = true },

        -- Auto-deref and auto-reborrow made visible: the `&*` you never wrote.
        -- `reborrow` shows only the reborrow cases; `always` also annotates every
        -- deref coercion, which gets noisy fast.
        expressionAdjustmentHints = { enable = 'reborrow' },

        -- Return type of closures that have a block body.
        closureReturnTypeHints = { enable = 'with_block' },

        -- Default is 25 characters, which truncates most generic types into
        -- uselessness (`impl Iterator<Item = R...`).
        maxLength = 50,

        -- Marks every point where a value is dropped. Genuinely useful while
        -- ownership is still new, genuinely noisy afterwards.
        -- implicitDrops = { enable = true },
      },

      -- cargo.features = 'all' analyses every feature flag at once. Fine on small
      -- crates, but on FOSS/nushell it pulls in polars and both memory use and
      -- index time go up sharply. Left at the default (no extra features).
      -- cargo = { features = 'all' },
    },
  },
}
