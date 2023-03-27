;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /[^/]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "/\u00B8\u0086\x1B"
(define-fun Witness1 () String (str.++ "/" (str.++ "\u{b8}" (str.++ "\u{86}" (str.++ "\u{1b}" "")))))
;witness2: "\u00C6/\u00AC\"
(define-fun Witness2 () String (str.++ "\u{c6}" (str.++ "/" (str.++ "\u{ac}" (str.++ "\u{5c}" "")))))

(assert (= regexA (re.++ (re.range "/" "/")(re.++ (re.+ (re.union (re.range "\u{00}" ".") (re.range "0" "\u{ff}"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
