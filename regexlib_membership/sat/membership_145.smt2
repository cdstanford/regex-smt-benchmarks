;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\<(\w){1,}\>(.){0,}([\</]|[\<])(\w){1,}\>$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<7\u00E2>\u00E5\u00A4\u00ADp<9>"
(define-fun Witness1 () String (str.++ "<" (str.++ "7" (str.++ "\u{e2}" (str.++ ">" (str.++ "\u{e5}" (str.++ "\u{a4}" (str.++ "\u{ad}" (str.++ "p" (str.++ "<" (str.++ "9" (str.++ ">" ""))))))))))))
;witness2: "<\u00D0><\u00AA>"
(define-fun Witness2 () String (str.++ "<" (str.++ "\u{d0}" (str.++ ">" (str.++ "<" (str.++ "\u{aa}" (str.++ ">" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range ">" ">")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.range "/" "/") (re.range "<" "<"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range ">" ">") (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
