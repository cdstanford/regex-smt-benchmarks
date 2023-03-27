;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{10,12}@[a-zA-Z].[a-zA-Z].*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x1A\u00ABBJ\x0,<469790199868@l\u00F3r\u00A3"
(define-fun Witness1 () String (str.++ "\u{1a}" (str.++ "\u{ab}" (str.++ "B" (str.++ "J" (str.++ "\u{00}" (str.++ "," (str.++ "<" (str.++ "4" (str.++ "6" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "0" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "@" (str.++ "l" (str.++ "\u{f3}" (str.++ "r" (str.++ "\u{a3}" "")))))))))))))))))))))))))
;witness2: "\u00ED88888568748@G\u009Cr@C"
(define-fun Witness2 () String (str.++ "\u{ed}" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "6" (str.++ "8" (str.++ "7" (str.++ "4" (str.++ "8" (str.++ "@" (str.++ "G" (str.++ "\u{9c}" (str.++ "r" (str.++ "@" (str.++ "C" "")))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 10 12) (re.range "0" "9"))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
