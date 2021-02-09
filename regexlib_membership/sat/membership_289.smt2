;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[ \t]+|[ \t]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C8 "
(define-fun Witness1 () String (seq.++ "\xc8" (seq.++ " " "")))
;witness2: "\x9"
(define-fun Witness2 () String (seq.++ "\x09" ""))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.+ (re.union (re.range "\x09" "\x09") (re.range " " " ")))) (re.++ (re.+ (re.union (re.range "\x09" "\x09") (re.range " " " "))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
