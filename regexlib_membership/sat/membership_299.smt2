;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?i)([À-ÿa-z\-]{2,})\x20([À-ÿa-z\-']{2,})(?-i)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CEc \u00FF-"
(define-fun Witness1 () String (str.++ "\u{ce}" (str.++ "c" (str.++ " " (str.++ "\u{ff}" (str.++ "-" ""))))))
;witness2: "-\u00CB \u00FA\u00C56"
(define-fun Witness2 () String (str.++ "-" (str.++ "\u{cb}" (str.++ " " (str.++ "\u{fa}" (str.++ "\u{c5}" (str.++ "6" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "-" "-")(re.union (re.range "a" "z") (re.range "\u{c0}" "\u{ff}")))) (re.* (re.union (re.range "-" "-")(re.union (re.range "a" "z") (re.range "\u{c0}" "\u{ff}")))))(re.++ (re.range " " " ") (re.++ ((_ re.loop 2 2) (re.union (re.range "'" "'")(re.union (re.range "-" "-")(re.union (re.range "a" "z") (re.range "\u{c0}" "\u{ff}"))))) (re.* (re.union (re.range "'" "'")(re.union (re.range "-" "-")(re.union (re.range "a" "z") (re.range "\u{c0}" "\u{ff}")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
