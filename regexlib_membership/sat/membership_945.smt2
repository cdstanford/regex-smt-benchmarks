;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([^,0-9]\D*)([0-9]*|\d*\,\d*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AE\u00AC\u00EEE\u00AC"
(define-fun Witness1 () String (seq.++ "\xae" (seq.++ "\xac" (seq.++ "\xee" (seq.++ "E" (seq.++ "\xac" ""))))))
;witness2: "\u00D40,8"
(define-fun Witness2 () String (seq.++ "\xd4" (seq.++ "0" (seq.++ "," (seq.++ "8" "")))))

(assert (= regexA (re.++ (re.++ (re.union (re.range "\x00" "+")(re.union (re.range "-" "/") (re.range ":" "\xff"))) (re.* (re.union (re.range "\x00" "/") (re.range ":" "\xff"))))(re.++ (re.union (re.* (re.range "0" "9")) (re.++ (re.* (re.range "0" "9"))(re.++ (re.range "," ",") (re.* (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
