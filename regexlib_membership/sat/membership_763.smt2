;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((ht|f)tp(s?):\/\/)|(([\w]{1,})\.[^ \[\]\(\)\n\r\t]+)|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})\/)([^ \[\]\(\),;"'<>\n\r\t]+)([^\. \[\]\(\),;"'<>\n\r\t])|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "B\xE\u00A6\u00E928.4.16.287\u00EB"
(define-fun Witness1 () String (str.++ "B" (str.++ "\u{0e}" (str.++ "\u{a6}" (str.++ "\u{e9}" (str.++ "2" (str.++ "8" (str.++ "." (str.++ "4" (str.++ "." (str.++ "1" (str.++ "6" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "7" (str.++ "\u{eb}" "")))))))))))))))))
;witness2: "_A.\u00FF<\u00B8\u00A5\x13\u00AD\u008B"
(define-fun Witness2 () String (str.++ "_" (str.++ "A" (str.++ "." (str.++ "\u{ff}" (str.++ "<" (str.++ "\u{b8}" (str.++ "\u{a5}" (str.++ "\u{13}" (str.++ "\u{ad}" (str.++ "\u{8b}" "")))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (str.++ "t" (str.++ "p" "")))(re.++ (re.opt (re.range "s" "s")) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))))))(re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "'")(re.union (re.range "*" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}")))))))))) (re.++ (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))) (re.range "/" "/"))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "+")(re.union (re.range "-" ":")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}")))))))))))) (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" ":")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "^" "\u{ff}")))))))))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
