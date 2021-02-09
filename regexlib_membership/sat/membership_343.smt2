;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]* {0,2}[A-Z]{1}\w+[,.;:]? {0,4}[xvilcXVILC\d]+[.,;:]( {0,2}[\d-,]{1,7})+)([,.;:] {0,4}[xvilcXVILC]*[.,;:]( {0,2}[\d-,]{1,7})+)*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "tVD ZA, 49x:  -;v,84\u00F6"
(define-fun Witness1 () String (seq.++ "t" (seq.++ "V" (seq.++ "D" (seq.++ " " (seq.++ "Z" (seq.++ "A" (seq.++ "," (seq.++ " " (seq.++ "4" (seq.++ "9" (seq.++ "x" (seq.++ ":" (seq.++ " " (seq.++ " " (seq.++ "-" (seq.++ ";" (seq.++ "v" (seq.++ "," (seq.++ "8" (seq.++ "4" (seq.++ "\xf6" ""))))))))))))))))))))))
;witness2: "25  A\u00CF\u00B5,    85.  2,,CVv,  3 8"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "5" (seq.++ " " (seq.++ " " (seq.++ "A" (seq.++ "\xcf" (seq.++ "\xb5" (seq.++ "," (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "8" (seq.++ "5" (seq.++ "." (seq.++ " " (seq.++ " " (seq.++ "2" (seq.++ "," (seq.++ "," (seq.++ "C" (seq.++ "V" (seq.++ "v" (seq.++ "," (seq.++ " " (seq.++ " " (seq.++ "3" (seq.++ " " (seq.++ "8" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.* (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.range " " " "))(re.++ (re.range "A" "Z")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.opt (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";"))))(re.++ ((_ re.loop 0 4) (re.range " " " "))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "C" "C")(re.union (re.range "I" "I")(re.union (re.range "L" "L")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "c" "c")(re.union (re.range "i" "i")(re.union (re.range "l" "l")(re.union (re.range "v" "v") (re.range "x" "x"))))))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";"))) (re.+ (re.++ ((_ re.loop 0 2) (re.range " " " ")) ((_ re.loop 1 7) (re.union (re.range "," "-") (re.range "0" "9"))))))))))))) (re.* (re.++ (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";")))(re.++ ((_ re.loop 0 4) (re.range " " " "))(re.++ (re.* (re.union (re.range "C" "C")(re.union (re.range "I" "I")(re.union (re.range "L" "L")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "c" "c")(re.union (re.range "i" "i")(re.union (re.range "l" "l")(re.union (re.range "v" "v") (re.range "x" "x")))))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";"))) (re.+ (re.++ ((_ re.loop 0 2) (re.range " " " ")) ((_ re.loop 1 7) (re.union (re.range "," "-") (re.range "0" "9")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
