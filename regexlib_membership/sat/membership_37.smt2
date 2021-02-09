;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<field1>[^,]+),(?<field2>[^,]+),(?<field3>[^,]+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u009E\u0097\u0094\u00FD\u00C2\x12,\u009E\x16,d\u00F6"
(define-fun Witness1 () String (seq.++ "\x9e" (seq.++ "\x97" (seq.++ "\x94" (seq.++ "\xfd" (seq.++ "\xc2" (seq.++ "\x12" (seq.++ "," (seq.++ "\x9e" (seq.++ "\x16" (seq.++ "," (seq.++ "d" (seq.++ "\xf6" "")))))))))))))
;witness2: "\u0094_\u00AD,/,-E"
(define-fun Witness2 () String (seq.++ "\x94" (seq.++ "_" (seq.++ "\xad" (seq.++ "," (seq.++ "/" (seq.++ "," (seq.++ "-" (seq.++ "E" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "+") (re.range "-" "\xff")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "+") (re.range "-" "\xff")))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\x00" "+") (re.range "-" "\xff"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
