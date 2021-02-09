;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[iI][mM][gG][a-zA-Z0-9\s=".]*((src)=\s*(?:"([^"]*)"|'[^']*'))[a-zA-Z0-9\s=".]*/*>(?:</[iI][mM][gG]>)*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F3\x0<ImGsrc=\u0085\u0085\'M\'>\u008B\x16\u00B5\xF"
(define-fun Witness1 () String (seq.++ "\xf3" (seq.++ "\x00" (seq.++ "<" (seq.++ "I" (seq.++ "m" (seq.++ "G" (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "'" (seq.++ "M" (seq.++ "'" (seq.++ ">" (seq.++ "\x8b" (seq.++ "\x16" (seq.++ "\xb5" (seq.++ "\x0f" "")))))))))))))))))))))
;witness2: "[\u00AE\u00CB<iMg\u0085src= \'\'></imG>~y\u00F7\xB"
(define-fun Witness2 () String (seq.++ "[" (seq.++ "\xae" (seq.++ "\xcb" (seq.++ "<" (seq.++ "i" (seq.++ "M" (seq.++ "g" (seq.++ "\x85" (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ " " (seq.++ "'" (seq.++ "'" (seq.++ ">" (seq.++ "<" (seq.++ "/" (seq.++ "i" (seq.++ "m" (seq.++ "G" (seq.++ ">" (seq.++ "~" (seq.++ "y" (seq.++ "\xf7" (seq.++ "\x0b" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "G" "G") (re.range "g" "g"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x22" "\x22")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))(re.++ (re.++ (str.to_re (seq.++ "s" (seq.++ "r" (seq.++ "c" ""))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))) (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'")))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x22" "\x22")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "=" "=")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))(re.++ (re.* (re.range "/" "/"))(re.++ (re.range ">" ">") (re.* (re.++ (str.to_re (seq.++ "<" (seq.++ "/" "")))(re.++ (re.union (re.range "I" "I") (re.range "i" "i"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "G" "G") (re.range "g" "g")) (re.range ">" ">")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
