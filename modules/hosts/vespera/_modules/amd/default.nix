{
  hardware = {
    graphics.enable = true;

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };
}
