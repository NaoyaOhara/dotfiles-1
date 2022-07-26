local border = {
  { "⣀", "LspBorderTop" },
  { "⣀", "LspBorderTop" },
  { "⣀", "LspBorderTop" },
  { "⢸", "LspBorderRight" },
  { "⠉", "LspBorderBottom" },
  { "⠉", "LspBorderBottom" },
  { "⠉", "LspBorderBottom" },
  { "⡇", "LspBorderLeft" },
}

local lua_globals = {
  "vim",
  "packer_plugins",
  "api",
  "fn",
  "loop",

  -- for testing
  "after_each",
  "before_each",
  "describe",
  "it",

  -- hammerspoon
  "hs",

  -- wrk
  "wrk",
  "setup",
  "id",
  "init",
  "request",
  "response",
  "done",

  "--formatter",
  "plain",
  "--codes",
  "--ranges",
  "--filename",
  "$FILENAME",
  "-",
}

return {
  border = border,

  lua_globals = lua_globals,

  on_attach = function(client, bufnr)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end

    api.buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local function goto_next()
      vim.diagnostic.goto_next { popup_opts = { border = border } }
    end

    vim.keymap.set("n", "<A-J>", goto_next, { buffer = bufnr })
    vim.keymap.set("n", "<A-S-Ô>", goto_next, { buffer = bufnr })

    local function goto_prev()
      vim.diagnostic.goto_prev { popup_opts = { border = border } }
    end

    vim.keymap.set("n", "<A-K>", goto_prev, { buffer = bufnr })
    vim.keymap.set("n", "<A-S->", goto_prev, { buffer = bufnr })

    vim.keymap.set("n", "<Space>E", function()
      if vim.b.lsp_diagnostics_disabled then
        vim.diagnostic.enable()
      else
        vim.diagnostic.disable()
      end
      vim.b.lsp_diagnostics_disabled = not vim.b.lsp_diagnostics_disabled
    end, { buffer = bufnr })
    vim.keymap.set("n", "<Space>e", function()
      vim.diagnostic.open_float { border = border }
    end, { buffer = bufnr })
    vim.keymap.set("n", "<Space>q", vim.diagnostic.setloclist, { buffer = bufnr })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, { buffer = bufnr })
    if vim.opt.filetype:get() ~= "help" then
      vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set("n", "<C-w><C-]>", function()
        vim.cmd.split()
        vim.lsp.buf.definition()
      end, { buffer = bufnr })
    end
    vim.keymap.set("n", "<C-x><C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { buffer = bufnr })
    vim.keymap.set("n", "gA", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.implementation, { buffer = bufnr })
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.declaration, { buffer = bufnr })
    vim.keymap.set("n", "gli", vim.lsp.buf.incoming_calls, { buffer = bufnr })
    vim.keymap.set("n", "glo", vim.lsp.buf.outgoing_calls, { buffer = bufnr })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })

    if client.supports_method "textDocument/formatting" then
      local auto_formatting = require("utils.lsp.auto_formatting").set(bufnr)
      vim.keymap.set("n", "g!", function()
        auto_formatting:toggle()
      end, { buffer = bufnr })
      vim.keymap.set("n", "g=", vim.lsp.buf.format, { buffer = bufnr })
    end
  end,

  update_tools = function()
    local notify = vim.schedule_wrap(function(msg, level)
      vim.cmd.redraw()
      vim.notify(msg, level)
    end)

    local Job = require "plenary.job"
    local function new_job(cmd, args, ...)
      local j = Job:new {
        command = cmd,
        args = args,
        on_start = function()
          notify("start: " .. cmd, vim.log.levels.DEBUG)
        end,
        on_exit = function(self, code)
          if code == 0 then
            notify("end: " .. cmd, vim.log.levels.DEBUG)
          else
            notify(self:stderr_result(), vim.log.levels.WARN)
          end
        end,
        enabled_recording = true,
      }
      local nexts = { j, ... }
      if #nexts > 1 then
        for i = 1, #nexts - 1 do
          nexts[i]:and_then_on_success(nexts[i + 1])
        end
      end
      return j
    end

    local formulae = {
      "ansible-lint",
      "checkmake",
      "coursier",
      "mypy",
      "shellcheck",
      "shfmt",
      "stylua",
      "vint",
      "yamllint",
    }

    local jobs = {
      new_job("cpanm", { "App::efm_perl" }),
      new_job("brew", { "install", unpack(formulae) }, new_job("brew", { "upgrade", unpack(formulae) })),
      new_job("gem", { "install", "--user-install", "rubocop" }),
      new_job(
        "luarocks",
        { "install", "luacheck" },
        new_job("luarocks", { "install", "--dev", "teal-language-server" })
      ),
      new_job(
        "go",
        { "install", "github.com/segmentio/golines@latest" },
        new_job("go", { "install", "mvdan.cc/gofumpt@latest" })
      ),
      new_job("npm", { "install", "-g", "textlint", "textlint-rule-preset-ja-spacing" }),
    }

    notify("update_tools: start", vim.log.levels.INFO)
    vim.tbl_map(function(j)
      j:start()
    end, jobs)
    Job.join(unpack(jobs))
    notify("update_tools: end", vim.log.levels.INFO)
  end,
}
