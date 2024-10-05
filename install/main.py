import os
# from subprocess import call

for i in os.listdir("."):
  if not i.endswith(".xml"):
    os.chmod(i, 0o755)

# for i in os.listdir("."):
#   if not i.endswith(".xml"):
#     print(f'chmod +x {i}')
#     call(f'chmod +x {i}')
#     print(f"execute permission granted for {i}")
