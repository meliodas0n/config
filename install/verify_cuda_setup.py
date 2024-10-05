#!/usr/bin/python3

from verify import Verify

assert hasattr(Verify, 'tensorflow')
assert hasattr(Verify, 'torch')

if __name__ == "__main__":
  import os

  uname = os.uname()
  sys_info = {"Platform" : uname.sysname, "Name" : uname.nodename, "Kernel" : uname.release, "Version Date" : uname.version, "Architecture" : uname.machine}
  print(f"System Info - \n{"\n".join([f"\t{key} : {value}" for key, value in sys_info.items()])}")

  Verify.tensorflow()
  Verify.torch()