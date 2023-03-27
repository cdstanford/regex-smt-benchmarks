;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^\*]{0,}[\*]{0,1}[^\*]{0,}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "g\u00A2\u00C5\u00C6\u00EF*}0"
(define-fun Witness1 () String (str.++ "g" (str.++ "\u{a2}" (str.++ "\u{c5}" (str.++ "\u{c6}" (str.++ "\u{ef}" (str.++ "*" (str.++ "}" (str.++ "0" "")))))))))
;witness2: "\u00F4\u0084\u00AE\u009A\u00DF"
(define-fun Witness2 () String (str.++ "\u{f4}" (str.++ "\u{84}" (str.++ "\u{ae}" (str.++ "\u{9a}" (str.++ "\u{df}" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{00}" ")") (re.range "+" "\u{ff}")))(re.++ (re.opt (re.range "*" "*"))(re.++ (re.* (re.union (re.range "\u{00}" ")") (re.range "+" "\u{ff}"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
