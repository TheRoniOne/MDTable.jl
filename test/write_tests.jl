using MDTables
using Test

@testset "Write Tests" begin
    let loaded = readMDTable("file.md")
        writeMDTable("fileTest.md", loaded)
        checking = readMDTable("fileTest.md")

        @test loaded == checking
    end
end
