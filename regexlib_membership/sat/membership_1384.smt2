;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .+\.([^.]+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "w\x12.\u00FD\u00E0\u00F9\u00C5\u0083"
(define-fun Witness1 () String (seq.++ "w" (seq.++ "\x12" (seq.++ "." (seq.++ "\xfd" (seq.++ "\xe0" (seq.++ "\xf9" (seq.++ "\xc5" (seq.++ "\x83" "")))))))))
;witness2: "^\u00A3\u00E1\u00ED.U"
(define-fun Witness2 () String (seq.++ "^" (seq.++ "\xa3" (seq.++ "\xe1" (seq.++ "\xed" (seq.++ "." (seq.++ "U" "")))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "\x00" "-") (re.range "/" "\xff"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
