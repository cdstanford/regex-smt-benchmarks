;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^#]([^ ]+ ){6}[^ ]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Yle r \x17\u00CC \u0096\u007F d,\x1B\x13 \u00CF\x6\u00C2 \u00B4\u00D3"
(define-fun Witness1 () String (str.++ "Y" (str.++ "l" (str.++ "e" (str.++ " " (str.++ "r" (str.++ " " (str.++ "\u{17}" (str.++ "\u{cc}" (str.++ " " (str.++ "\u{96}" (str.++ "\u{7f}" (str.++ " " (str.++ "d" (str.++ "," (str.++ "\u{1b}" (str.++ "\u{13}" (str.++ " " (str.++ "\u{cf}" (str.++ "\u{06}" (str.++ "\u{c2}" (str.++ " " (str.++ "\u{b4}" (str.++ "\u{d3}" ""))))))))))))))))))))))))
;witness2: "\u00D9\u0096 \u00CD \u00AE\u00EE \u007F \u00B77n \u009F \x9"
(define-fun Witness2 () String (str.++ "\u{d9}" (str.++ "\u{96}" (str.++ " " (str.++ "\u{cd}" (str.++ " " (str.++ "\u{ae}" (str.++ "\u{ee}" (str.++ " " (str.++ "\u{7f}" (str.++ " " (str.++ "\u{b7}" (str.++ "7" (str.++ "n" (str.++ " " (str.++ "\u{9f}" (str.++ " " (str.++ "\u{09}" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "\u{00}" "\u{22}") (re.range "$" "\u{ff}"))(re.++ ((_ re.loop 6 6) (re.++ (re.+ (re.union (re.range "\u{00}" "\u{1f}") (re.range "!" "\u{ff}"))) (re.range " " " ")))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{1f}") (re.range "!" "\u{ff}"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
