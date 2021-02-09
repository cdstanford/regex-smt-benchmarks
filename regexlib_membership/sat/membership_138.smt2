;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z_-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "3Zm4_8_vN@Z.gxY"
(define-fun Witness1 () String (seq.++ "3" (seq.++ "Z" (seq.++ "m" (seq.++ "4" (seq.++ "_" (seq.++ "8" (seq.++ "_" (seq.++ "v" (seq.++ "N" (seq.++ "@" (seq.++ "Z" (seq.++ "." (seq.++ "g" (seq.++ "x" (seq.++ "Y" ""))))))))))))))))
;witness2: "0@A8.-OW.YlZ"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "@" (seq.++ "A" (seq.++ "8" (seq.++ "." (seq.++ "-" (seq.++ "O" (seq.++ "W" (seq.++ "." (seq.++ "Y" (seq.++ "l" (seq.++ "Z" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.union (re.range "&" "&")(re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range ";" ";")(re.union (re.range "_" "_")(re.union (re.range "a" "a")(re.union (re.range "m" "m") (re.range "p" "p"))))))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
