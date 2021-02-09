;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((?:(?:(?:[a-zA-Z0-9][\.\-\+_]?)*)[a-zA-Z0-9])+)\@((?:(?:(?:[a-zA-Z0-9][\.\-_]?){0,62})[a-zA-Z0-9])+)\.([a-zA-Z0-9]{2,6})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "zY@9_t7_P.92_8.8XZz2"
(define-fun Witness1 () String (seq.++ "z" (seq.++ "Y" (seq.++ "@" (seq.++ "9" (seq.++ "_" (seq.++ "t" (seq.++ "7" (seq.++ "_" (seq.++ "P" (seq.++ "." (seq.++ "9" (seq.++ "2" (seq.++ "_" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "X" (seq.++ "Z" (seq.++ "z" (seq.++ "2" "")))))))))))))))))))))
;witness2: "v@48.83"
(define-fun Witness2 () String (seq.++ "v" (seq.++ "@" (seq.++ "4" (seq.++ "8" (seq.++ "." (seq.++ "8" (seq.++ "3" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.* (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" ".") (re.range "_" "_")))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ ((_ re.loop 0 62) (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.union (re.range "-" ".") (re.range "_" "_"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 6) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
