import Danger

let danger = Danger()

let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles

for file in allSourceFiles where danger.utils.readFile(file).contains("Copyright ") {
    warn("Remove please copyright at file \(file.name)")
}
