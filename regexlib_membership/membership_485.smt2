;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(|(0\d)|(1[0-2])):(([0-5]\d)):(([0-5]\d))\s([AP]M)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "12:59:21 PM"
(define-fun Witness1 () String (str.++ "1" (str.++ "2" (str.++ ":" (str.++ "5" (str.++ "9" (str.++ ":" (str.++ "2" (str.++ "1" (str.++ " " (str.++ "P" (str.++ "M" ""))))))))))))
;witness2: ":28:52\xCAM"
(define-fun Witness2 () String (str.++ ":" (str.++ "2" (str.++ "8" (str.++ ":" (str.++ "5" (str.++ "2" (str.++ "\u{0c}" (str.++ "A" (str.++ "M" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re "")(re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.++ (re.union (re.range "A" "A") (re.range "P" "P")) (re.range "M" "M")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
