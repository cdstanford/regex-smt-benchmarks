;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]+)\s(d)\s(([0-1][0-9])|([2][0-3])):([0-5][0-9]):([0-5][0-9])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00D3\u00F7V85\xDd\xD09:54:15"
(define-fun Witness1 () String (str.++ "\u{d3}" (str.++ "\u{f7}" (str.++ "V" (str.++ "8" (str.++ "5" (str.++ "\u{0d}" (str.++ "d" (str.++ "\u{0d}" (str.++ "0" (str.++ "9" (str.++ ":" (str.++ "5" (str.++ "4" (str.++ ":" (str.++ "1" (str.++ "5" "")))))))))))))))))
;witness2: "\u00E7\u00CB\u0087\u00A38\u0085d\u008523:43:07CC"
(define-fun Witness2 () String (str.++ "\u{e7}" (str.++ "\u{cb}" (str.++ "\u{87}" (str.++ "\u{a3}" (str.++ "8" (str.++ "\u{85}" (str.++ "d" (str.++ "\u{85}" (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "4" (str.++ "3" (str.++ ":" (str.++ "0" (str.++ "7" (str.++ "C" (str.++ "C" "")))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.range "d" "d")(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
