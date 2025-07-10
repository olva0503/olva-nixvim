{
  autoCmd = [
    {
      command = "setlocal tabstop=2 shiftwidth=2";
      event = [
        "BufEnter"
        "BufWinEnter"
      ];
      pattern = [
        "*.feature"
      ];
    }
    {
      command = "RustFmt";
      event = [
        "BufWritePre"
      ];
      pattern = [
        "*.rs"
      ];
    }
    # { # too raw
    #   event = [
    #     "LspAttach"
    #   ];
    #   callback.__raw = ''
    #     function(ev)
    #       local client = vim.lsp.get_client_by_id(ev.data.client_id)
    #       if client:supports_method('textDocument/completion') then
    #           vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    #       end
    #     end
    #   '';
    # }
  ];
}
