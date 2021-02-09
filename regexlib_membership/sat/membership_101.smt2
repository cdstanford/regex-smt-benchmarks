;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z]{2,3}(\.[a-zA-Z][a-zA-Z_$0-9]*)*)\.([A-Z][a-zA-Z_$0-9]*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "tzx.E.M"
(define-fun Witness1 () String (seq.++ "t" (seq.++ "z" (seq.++ "x" (seq.++ "." (seq.++ "E" (seq.++ "." (seq.++ "M" ""))))))))
;witness2: "mi.G.N$J$"
(define-fun Witness2 () String (seq.++ "m" (seq.++ "i" (seq.++ "." (seq.++ "G" (seq.++ "." (seq.++ "N" (seq.++ "$" (seq.++ "J" (seq.++ "$" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 3) (re.range "a" "z")) (re.* (re.++ (re.range "." ".")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "$" "$")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.range "." ".")(re.++ (re.++ (re.range "A" "Z") (re.* (re.union (re.range "$" "$")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
