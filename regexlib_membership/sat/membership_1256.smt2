;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\S*)+(\u007C)+(\S*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00D3\x4}\u0091|||||||"
(define-fun Witness1 () String (str.++ "\u{d3}" (str.++ "\u{04}" (str.++ "}" (str.++ "\u{91}" (str.++ "|" (str.++ "|" (str.++ "|" (str.++ "|" (str.++ "|" (str.++ "|" (str.++ "|" ""))))))))))))
;witness2: "%\x1B\u00D3|\u0098c\x4"
(define-fun Witness2 () String (str.++ "%" (str.++ "\u{1b}" (str.++ "\u{d3}" (str.++ "|" (str.++ "\u{98}" (str.++ "c" (str.++ "\u{04}" ""))))))))

(assert (= regexA (re.++ (re.+ (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))(re.++ (re.+ (re.range "|" "|")) (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
