;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9;9@-x.xJ"
(define-fun Witness1 () String (seq.++ "9" (seq.++ ";" (seq.++ "9" (seq.++ "@" (seq.++ "-" (seq.++ "x" (seq.++ "." (seq.++ "x" (seq.++ "J" ""))))))))))
;witness2: "D939Z-9.p@2.8.Go"
(define-fun Witness2 () String (seq.++ "D" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "Z" (seq.++ "-" (seq.++ "9" (seq.++ "." (seq.++ "p" (seq.++ "@" (seq.++ "2" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "G" (seq.++ "o" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.union (re.range "&" "&")(re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range ";" ";")(re.union (re.range "_" "_")(re.union (re.range "a" "a")(re.union (re.range "m" "m") (re.range "p" "p"))))))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
