;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^["a-zA-Z0-9\040]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9"
(define-fun Witness1 () String (seq.++ "9" ""))
;witness2: "D"
(define-fun Witness2 () String (seq.++ "D" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "\x22" "\x22")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
