function idl = correctIDL(idl)
for i = 1:length(idl)
    idl(i).bb = correctBBox(idl(i).bb);
end
end