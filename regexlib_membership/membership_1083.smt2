;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\x01-\x08,\x0A-\x1F,\x7F,\x81,\x8D,\x8F,\x90,\x9D]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u007F"
(define-fun Witness1 () String (str.++ "\u{7f}" ""))
;witness2: "\x15\u0094\u009D@"
(define-fun Witness2 () String (str.++ "\u{15}" (str.++ "\u{94}" (str.++ "\u{9d}" (str.++ "@" "")))))

(assert (= regexA (re.union (re.range "\u{01}" "\u{08}")(re.union (re.range "\u{0a}" "\u{1f}")(re.union (re.range "," ",")(re.union (re.range "\u{7f}" "\u{7f}")(re.union (re.range "\u{81}" "\u{81}")(re.union (re.range "\u{8d}" "\u{8d}")(re.union (re.range "\u{8f}" "\u{90}") (re.range "\u{9d}" "\u{9d}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
