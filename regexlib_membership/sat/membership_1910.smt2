;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]\w{3,14}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "zy\u00C5K\u00EE4"
(define-fun Witness1 () String (seq.++ "z" (seq.++ "y" (seq.++ "\xc5" (seq.++ "K" (seq.++ "\xee" (seq.++ "4" "")))))))
;witness2: "t\u00B5\u00AAz\u00AA"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "\xb5" (seq.++ "\xaa" (seq.++ "z" (seq.++ "\xaa" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ ((_ re.loop 3 14) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
