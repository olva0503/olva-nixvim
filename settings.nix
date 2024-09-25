{
 globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    opts.completeopt = ["menu" "menuone" "noselect"];
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };
    opts = {
      updatetime = 10;
      relativenumber = true;
      wrap = true;
      cursorline = true;
      number = true;
      smartindent = true;
      swapfile = false;
      breakindent = true;
      undofile = true;
      incsearch = true;
      ignorecase = true;
      colorcolumn = "135";
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      foldcolumn = "0";
      autoindent = true;
      foldlevel = 99;
      hlsearch = true;
      foldlevelstart = 99;
      foldenable = true;
      scrolloff = 16;
      # timeoutlen = 10;
      list = true;
      spell = true;
      spelllang = ["en_us"];
    };
}
