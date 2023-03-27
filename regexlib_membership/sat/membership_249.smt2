;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \\s\\d{2}[-]\\w{3}-\\d{4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\s\dd-\www-\ddddX"
(define-fun Witness1 () String (str.++ "\u{5c}" (str.++ "s" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "-" (str.++ "\u{5c}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "-" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "X" ""))))))))))))))))))
;witness2: "\u00E3\s\dd-\www-\dddd\u00EA\u00CD\u00D2"
(define-fun Witness2 () String (str.++ "\u{e3}" (str.++ "\u{5c}" (str.++ "s" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "-" (str.++ "\u{5c}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "-" (str.++ "\u{5c}" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "d" (str.++ "\u{ea}" (str.++ "\u{cd}" (str.++ "\u{d2}" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "\u{5c}" (str.++ "s" (str.++ "\u{5c}" ""))))(re.++ ((_ re.loop 2 2) (re.range "d" "d"))(re.++ (str.to_re (str.++ "-" (str.++ "\u{5c}" "")))(re.++ ((_ re.loop 3 3) (re.range "w" "w"))(re.++ (str.to_re (str.++ "-" (str.++ "\u{5c}" ""))) ((_ re.loop 4 4) (re.range "d" "d")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
