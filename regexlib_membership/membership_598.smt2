;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d{1,2}(\:|\s)\d{1,2}(\:|\s)\d{1,2}\s*(AM|PM|A|P))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A8\u00AB\u00990 8 88\u00A0P\u00DD"
(define-fun Witness1 () String (str.++ "\u{a8}" (str.++ "\u{ab}" (str.++ "\u{99}" (str.++ "0" (str.++ " " (str.++ "8" (str.++ " " (str.++ "8" (str.++ "8" (str.++ "\u{a0}" (str.++ "P" (str.++ "\u{dd}" "")))))))))))))
;witness2: "\u00BF8\u00A04\u008598\u0085\u0085\xBPM\u00D8\x2\u00F1\u00B0"
(define-fun Witness2 () String (str.++ "\u{bf}" (str.++ "8" (str.++ "\u{a0}" (str.++ "4" (str.++ "\u{85}" (str.++ "9" (str.++ "8" (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{0b}" (str.++ "P" (str.++ "M" (str.++ "\u{d8}" (str.++ "\u{02}" (str.++ "\u{f1}" (str.++ "\u{b0}" "")))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range ":" ":")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range ":" ":")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" ""))) (re.union (re.range "A" "A") (re.range "P" "P"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
