;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^0-9]*(?:(\d)[^0-9]*){10}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x7\x2\u0099956\u00AB1\u009C\u008681\u00A581\u00D6\x0\u0090_88"
(define-fun Witness1 () String (str.++ "\u{07}" (str.++ "\u{02}" (str.++ "\u{99}" (str.++ "9" (str.++ "5" (str.++ "6" (str.++ "\u{ab}" (str.++ "1" (str.++ "\u{9c}" (str.++ "\u{86}" (str.++ "8" (str.++ "1" (str.++ "\u{a5}" (str.++ "8" (str.++ "1" (str.++ "\u{d6}" (str.++ "\u{00}" (str.++ "\u{90}" (str.++ "_" (str.++ "8" (str.++ "8" ""))))))))))))))))))))))
;witness2: "0\u0083X29\u00DA\u0090[58604\u00F29F 3\u00BD\'\"
(define-fun Witness2 () String (str.++ "0" (str.++ "\u{83}" (str.++ "X" (str.++ "2" (str.++ "9" (str.++ "\u{da}" (str.++ "\u{90}" (str.++ "[" (str.++ "5" (str.++ "8" (str.++ "6" (str.++ "0" (str.++ "4" (str.++ "\u{f2}" (str.++ "9" (str.++ "F" (str.++ " " (str.++ "3" (str.++ "\u{bd}" (str.++ "'" (str.++ "\u{5c}" ""))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 10 10) (re.++ (re.range "0" "9") (re.* (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
