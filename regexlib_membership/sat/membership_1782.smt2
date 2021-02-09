;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = @{2}((\S)+)@{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B1_\u00AD@@\u00C2\u00AC@@"
(define-fun Witness1 () String (seq.++ "\xb1" (seq.++ "_" (seq.++ "\xad" (seq.++ "@" (seq.++ "@" (seq.++ "\xc2" (seq.++ "\xac" (seq.++ "@" (seq.++ "@" ""))))))))))
;witness2: "\x2\x13@@J\u00EA@@"
(define-fun Witness2 () String (seq.++ "\x02" (seq.++ "\x13" (seq.++ "@" (seq.++ "@" (seq.++ "J" (seq.++ "\xea" (seq.++ "@" (seq.++ "@" "")))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.range "@" "@"))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))) ((_ re.loop 2 2) (re.range "@" "@"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
