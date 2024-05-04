ExUnit.start()
Mix.Task.run("ash.codegen", ["test"])
Mix.Task.run("ash.migrate", ["--quiet"])
