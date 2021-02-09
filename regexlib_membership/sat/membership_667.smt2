;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{10,12}@[a-zA-Z].[a-zA-Z].*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1A\u00ABBJ\x0,<469790199868@l\u00F3r\u00A3"
(define-fun Witness1 () String (seq.++ "\x1a" (seq.++ "\xab" (seq.++ "B" (seq.++ "J" (seq.++ "\x00" (seq.++ "," (seq.++ "<" (seq.++ "4" (seq.++ "6" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "0" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "@" (seq.++ "l" (seq.++ "\xf3" (seq.++ "r" (seq.++ "\xa3" "")))))))))))))))))))))))))
;witness2: "\u00ED88888568748@G\u009Cr@C"
(define-fun Witness2 () String (seq.++ "\xed" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "5" (seq.++ "6" (seq.++ "8" (seq.++ "7" (seq.++ "4" (seq.++ "8" (seq.++ "@" (seq.++ "G" (seq.++ "\x9c" (seq.++ "r" (seq.++ "@" (seq.++ "C" "")))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 10 12) (re.range "0" "9"))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
