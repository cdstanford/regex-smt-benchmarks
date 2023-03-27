;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\s|[0])\.(\d{0,2}\s{0,2}))?$|^(\.(\d\s){0,2})?$|^(\s{0,4}[1]{0,1}\.[0]{0,2}\s{0,4})?$|^(\s{0,4}[1]{0,1}\s{0,4})?$|^(\s{0,4}[0]{0,4}[1]{0,1}\s{0,4})?$|^([0]{0,4}\s{0,4})?$|^(\s{0,3}[0]{0,3}\.{1}\d{0,2}\s{0,2})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: " .\u00A0 "
(define-fun Witness1 () String (str.++ " " (str.++ "." (str.++ "\u{a0}" (str.++ " " "")))))
;witness2: ""
(define-fun Witness2 () String "")

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "0" "0")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "." ".") (re.++ ((_ re.loop 0 2) (re.range "0" "9")) ((_ re.loop 0 2) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.++ (re.range "0" "9") (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 0 4) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "1" "1"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 0 2) (re.range "0" "0")) ((_ re.loop 0 4) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 0 4) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "1" "1")) ((_ re.loop 0 4) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 0 4) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 0 4) (re.range "0" "0"))(re.++ (re.opt (re.range "1" "1")) ((_ re.loop 0 4) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 0 4) (re.range "0" "0")) ((_ re.loop 0 4) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.opt (re.++ ((_ re.loop 0 3) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 0 3) (re.range "0" "0"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) ((_ re.loop 0 2) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
