;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\d]{3}[\s\-]*[\d]{3}[\s\-]*[\d]{4}\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "695\xB\u00858899984\xC"
(define-fun Witness1 () String (str.++ "6" (str.++ "9" (str.++ "5" (str.++ "\u{0b}" (str.++ "\u{85}" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "4" (str.++ "\u{0c}" ""))))))))))))))
;witness2: "1396184299\xA"
(define-fun Witness2 () String (str.++ "1" (str.++ "3" (str.++ "9" (str.++ "6" (str.++ "1" (str.++ "8" (str.++ "4" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ "\u{0a}" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
