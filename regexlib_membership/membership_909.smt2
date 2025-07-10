;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ;?(?:(?:"((?:[^"]|"")*)")|([^;]*))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x1C\"\"\u009E\u00EC\u00B3\u0092"
(define-fun Witness1 () String (str.++ "\u{1c}" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "\u{9e}" (str.++ "\u{ec}" (str.++ "\u{b3}" (str.++ "\u{92}" ""))))))))
;witness2: "\u00D5&1\u0085"
(define-fun Witness2 () String (str.++ "\u{d5}" (str.++ "&" (str.++ "1" (str.++ "\u{85}" "")))))

(assert (= regexA (re.++ (re.opt (re.range ";" ";")) (re.union (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}")) (str.to_re (str.++ "\u{22}" (str.++ "\u{22}" ""))))) (re.range "\u{22}" "\u{22}"))) (re.* (re.union (re.range "\u{00}" ":") (re.range "<" "\u{ff}")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
