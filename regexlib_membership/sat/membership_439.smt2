;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\(")([0-9]*)(\")
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(\"89926\""
(define-fun Witness1 () String (seq.++ "(" (seq.++ "\x22" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "2" (seq.++ "6" (seq.++ "\x22" "")))))))))
;witness2: "(\"\""
(define-fun Witness2 () String (seq.++ "(" (seq.++ "\x22" (seq.++ "\x22" ""))))

(assert (= regexA (re.++ (str.to_re (seq.++ "(" (seq.++ "\x22" "")))(re.++ (re.* (re.range "0" "9")) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
