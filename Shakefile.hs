import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util


hostsFile = "hosts"


main :: IO ()
main = shakeArgs shakeOptions $ do
  "ping" ~> cmd "ansible all -i" hostsFile "-m ping"
  "setup" ~> do
    cmd "ansible-playbook --ask-vault-pass --ask-become-pass -i" hostsFile
        "setup.yml"
  "clean" ~> do
    cmd Shell "rm -f *.retry"
