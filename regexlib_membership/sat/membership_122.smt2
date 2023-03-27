;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^.*(?:kumar).*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\\u00E7\x11kumar"
(define-fun Witness1 () String (str.++ "\u{5c}" (str.++ "\u{e7}" (str.++ "\u{11}" (str.++ "k" (str.++ "u" (str.++ "m" (str.++ "a" (str.++ "r" "")))))))))
;witness2: "\u00E3`\u00B2\xCS\xCkumar\u00B9"
(define-fun Witness2 () String (str.++ "\u{e3}" (str.++ "`" (str.++ "\u{b2}" (str.++ "\u{0c}" (str.++ "S" (str.++ "\u{0c}" (str.++ "k" (str.++ "u" (str.++ "m" (str.++ "a" (str.++ "r" (str.++ "\u{b9}" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ "k" (str.++ "u" (str.++ "m" (str.++ "a" (str.++ "r" ""))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
