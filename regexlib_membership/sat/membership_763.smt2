;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((ht|f)tp(s?):\/\/)|(([\w]{1,})\.[^ \[\]\(\)\n\r\t]+)|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})\/)([^ \[\]\(\),;"'<>\n\r\t]+)([^\. \[\]\(\),;"'<>\n\r\t])|(([012]?[0-9]{1,2}\.){3}[012]?[0-9]{1,2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "B\xE\u00A6\u00E928.4.16.287\u00EB"
(define-fun Witness1 () String (seq.++ "B" (seq.++ "\x0e" (seq.++ "\xa6" (seq.++ "\xe9" (seq.++ "2" (seq.++ "8" (seq.++ "." (seq.++ "4" (seq.++ "." (seq.++ "1" (seq.++ "6" (seq.++ "." (seq.++ "2" (seq.++ "8" (seq.++ "7" (seq.++ "\xeb" "")))))))))))))))))
;witness2: "_A.\u00FF<\u00B8\u00A5\x13\u00AD\u008B"
(define-fun Witness2 () String (seq.++ "_" (seq.++ "A" (seq.++ "." (seq.++ "\xff" (seq.++ "<" (seq.++ "\xb8" (seq.++ "\xa5" (seq.++ "\x13" (seq.++ "\xad" (seq.++ "\x8b" "")))))))))))

(assert (= regexA (re.union (re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (seq.++ "t" (seq.++ "p" "")))(re.++ (re.opt (re.range "s" "s")) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))))(re.union (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "." ".") (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "'")(re.union (re.range "*" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff")))))))))) (re.++ (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))) (re.range "/" "/"))))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "+")(re.union (re.range "-" ":")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff")))))))))))) (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" ":")(re.union (re.range "=" "=")(re.union (re.range "?" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff")))))))))))))) (re.++ ((_ re.loop 3 3) (re.++ (re.opt (re.range "0" "2"))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "." "."))))(re.++ (re.opt (re.range "0" "2")) ((_ re.loop 1 2) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
