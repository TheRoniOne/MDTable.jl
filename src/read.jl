using DataFrames: DataFrame, FileIO

function readMDTable(file::String; header::Bool=true)::DataFrame
    mdTable = Dict()
    headersClean::Array = []
    skip::Bool = header
    for line in eachline(file)
        if header
            parseHeader!(line, mdTable, headersClean)
            header = false
        elseif skip
            skip = false
        else
            parseLine!(line, mdTable, headersClean)
        end
    end
    return DataFrame(mdTable)
end

function parseHeader!(line::String, mdTable::Dict, headersClean::Array)
    headersDirty = split(line, "|")
    for value in headersDirty
        key = lstrip(rstrip(value))
        if key != ""
            mdTable[key] = []
            push!(headersClean, key)
        end
    end
end

function parseLine!(line::String, mdTable::Dict, headersClean::Array)
    values = split(line, "|", keepempty=false)
    if length(values) != length(headersClean)
        error("The number of values in a line must be the same as the number of headers of the file")
    end

    for i in 1:length(values)
        value = lstrip(rstrip(values[i]))
        push!(mdTable[headersClean[i]], value)
    end
end

function load(f::File{format"MD"}; header::Bool=true)
    return readMDTable(f.filename, header=header)
end
