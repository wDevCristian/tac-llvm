clang++ -o ir ast_to_ir.cpp $(llvm-config --cxxflags --ldflags --system-libs --libs core) -fexceptions
./ir > ir.ll