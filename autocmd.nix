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
  ];
}
