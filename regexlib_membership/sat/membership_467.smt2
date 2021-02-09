;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0]|[0-3]\.(\d?\d?)|[4].[0]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0"
(define-fun Witness1 () String (seq.++ "0" ""))
;witness2: "\u00D04\u00950"
(define-fun Witness2 () String (seq.++ "\xd0" (seq.++ "4" (seq.++ "\x95" (seq.++ "0" "")))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.range "0" "0"))(re.union (re.++ (re.range "0" "3")(re.++ (re.range "." ".") (re.++ (re.opt (re.range "0" "9")) (re.opt (re.range "0" "9"))))) (re.++ (re.range "4" "4")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "0" "0") (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
