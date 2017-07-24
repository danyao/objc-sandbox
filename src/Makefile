OUT=bin

clean:
	rm -rf ${OUT}

${OUT}:
	mkdir bin

hello: hello.m ${OUT}
	gcc -o ${OUT}/hello hello.m -lobjc -framework Foundation

strings: strings.m ${OUT}
	gcc -o ${OUT}/strings strings.m -lobjc -framework Foundation

associated_obj: associated_obj.mm ${OUT}
	g++ -o ${OUT}/associated_obj associated_obj.mm -lobjc -framework Foundation
