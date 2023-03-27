;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '(?<document>.*)'\)(?<path>.*)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "6\u00ED7\';\u0087\')"
(define-fun Witness1 () String (str.++ "6" (str.++ "\u{ed}" (str.++ "7" (str.++ "'" (str.++ ";" (str.++ "\u{87}" (str.++ "'" (str.++ ")" "")))))))))
;witness2: "K\'\')v\u00C3"
(define-fun Witness2 () String (str.++ "K" (str.++ "'" (str.++ "'" (str.++ ")" (str.++ "v" (str.++ "\u{c3}" "")))))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ "'" (str.++ ")" ""))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
