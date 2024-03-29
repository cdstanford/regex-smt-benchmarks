;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "[^"]+" 
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00B1\"\u00A7\" "
(define-fun Witness1 () String (str.++ "\u{b1}" (str.++ "\u{22}" (str.++ "\u{a7}" (str.++ "\u{22}" (str.++ " " ""))))))
;witness2: "\x14I\"\u00A3\" "
(define-fun Witness2 () String (str.++ "\u{14}" (str.++ "I" (str.++ "\u{22}" (str.++ "\u{a3}" (str.++ "\u{22}" (str.++ " " "")))))))

(assert (= regexA (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.+ (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (str.to_re (str.++ "\u{22}" (str.++ " " "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
