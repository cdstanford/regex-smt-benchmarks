;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]* {0,2}[A-Z]{1}\w+[,.;:]? {0,4}[xvilcXVILC\d]+[.,;:]( {0,2}[\d-,]{1,7})+)([,.;:] {0,4}[xvilcXVILC]*[.,;:]( {0,2}[\d-,]{1,7})+)*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "tVD ZA, 49x:  -;v,84\u00F6"
(define-fun Witness1 () String (str.++ "t" (str.++ "V" (str.++ "D" (str.++ " " (str.++ "Z" (str.++ "A" (str.++ "," (str.++ " " (str.++ "4" (str.++ "9" (str.++ "x" (str.++ ":" (str.++ " " (str.++ " " (str.++ "-" (str.++ ";" (str.++ "v" (str.++ "," (str.++ "8" (str.++ "4" (str.++ "\u{f6}" ""))))))))))))))))))))))
;witness2: "25  A\u00CF\u00B5,    85.  2,,CVv,  3 8"
(define-fun Witness2 () String (str.++ "2" (str.++ "5" (str.++ " " (str.++ " " (str.++ "A" (str.++ "\u{cf}" (str.++ "\u{b5}" (str.++ "," (str.++ " " (str.++ " " (str.++ " " (str.++ " " (str.++ "8" (str.++ "5" (str.++ "." (str.++ " " (str.++ " " (str.++ "2" (str.++ "," (str.++ "," (str.++ "C" (str.++ "V" (str.++ "v" (str.++ "," (str.++ " " (str.++ " " (str.++ "3" (str.++ " " (str.++ "8" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.* (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.range " " " "))(re.++ (re.range "A" "Z")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.opt (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";"))))(re.++ ((_ re.loop 0 4) (re.range " " " "))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "C" "C")(re.union (re.range "I" "I")(re.union (re.range "L" "L")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "c" "c")(re.union (re.range "i" "i")(re.union (re.range "l" "l")(re.union (re.range "v" "v") (re.range "x" "x"))))))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";"))) (re.+ (re.++ ((_ re.loop 0 2) (re.range " " " ")) ((_ re.loop 1 7) (re.union (re.range "," "-") (re.range "0" "9"))))))))))))) (re.* (re.++ (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";")))(re.++ ((_ re.loop 0 4) (re.range " " " "))(re.++ (re.* (re.union (re.range "C" "C")(re.union (re.range "I" "I")(re.union (re.range "L" "L")(re.union (re.range "V" "V")(re.union (re.range "X" "X")(re.union (re.range "c" "c")(re.union (re.range "i" "i")(re.union (re.range "l" "l")(re.union (re.range "v" "v") (re.range "x" "x")))))))))))(re.++ (re.union (re.range "," ",")(re.union (re.range "." ".") (re.range ":" ";"))) (re.+ (re.++ ((_ re.loop 0 2) (re.range " " " ")) ((_ re.loop 1 7) (re.union (re.range "," "-") (re.range "0" "9")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
